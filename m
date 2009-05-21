From: Aneesh Bhasin <contact.aneesh@gmail.com>
Subject: Re: cpuidle C-state accounting
Date: Thu, 21 May 2009 22:55:53 +0530
Message-ID: <f662f0210905211025h1910590fi54b2d4e269c6ad6a@mail.gmail.com>
References: <20090519162504.GA26660@linux-foundation.org>
	<13B9B4C6EF24D648824FF11BE8967162038BED6777@dlee02.ent.ti.com>
	<f2235a630905200236v29f407dfne77c55165ed94249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f2235a630905200236v29f407dfne77c55165ed94249@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Surinder P Singh <srplsnh@gmail.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Surinder,

On Wed, May 20, 2009 at 3:06 PM, Surinder P Singh <srplsnh@gmail.com> wrote:
>> In code I've used I don't demote other states. =A0But there are state ab=
orts. =A0In those cases residency is low or 0.
>
> Indeed, its the residency=3D0 cases that the patch I sent in my last
> mail attempts to fix. The idea being, not to increment
> target_state->usage if dev->last_residency was 0, i.e. the state
> (whether it was the governor recommended state or =A0safe_state or any
> other state) was =A0not entered or used.

That being the case , perhaps it will be useful to then have an extra
'usage' stat which shows such scenarios too for analysis purpose.
Patch below :

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 9ab50be..a835bc2 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -57,7 +57,10 @@ static void cpuidle_idle_call(void)
        dev->last_residency =3D target_state->enter(dev, target_state);
        dev->last_state =3D target_state;
        target_state->time +=3D dev->last_residency;
-       target_state->usage++;
+  if(dev->last_residency)
+    target_state->usage++;
+  else
+    target_state->usage_nosuccess++;

        /* give the governor an opportunity to reflect on the outcome */
        if (cpuidle_curr_governor->reflect)
@@ -137,6 +140,7 @@ int cpuidle_enable_device(struct cpuidle_device *dev)

        for (i =3D 0; i < dev->state_count; i++) {
                dev->states[i].usage =3D 0;
+               dev->states[i].usage_nosuccess =3D 0;
                dev->states[i].time =3D 0;
        }
        dev->last_residency =3D 0;
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 0f3515e..eaf21a1 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -226,6 +226,7 @@ static ssize_t show_state_name(struct
cpuidle_state *state, char *buf)
 define_show_state_function(exit_latency)
 define_show_state_function(power_usage)
 define_show_state_function(usage)
+define_show_state_function(usage_nosuccess)
 define_show_state_function(time)
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(latency, show_state_exit_latency);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index c4e0016..71fe0ac 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -37,6 +37,7 @@ struct cpuidle_state {
        unsigned int    target_residency; /* in US */

        unsigned int    usage;
+       unsigned int    usage_nosuccess;
        unsigned int    time; /* in US */

        int (*enter)    (struct cpuidle_device *dev,

Regards,
Aneesh
