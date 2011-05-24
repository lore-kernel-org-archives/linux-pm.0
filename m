From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] PM: OPP: introduce function to free cpufreq
	table
Date: Mon, 23 May 2011 21:42:21 -0500
Message-ID: <BANLkTi=mo_o=WCHg27XeOTYP9gDEFROMVQ__43970.6865502105$1306205082$gmane$org@mail.gmail.com>
References: <1306192335-19883-1-git-send-email-nm@ti.com>
	<20110524000549.GA20225@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110524000549.GA20225@google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 23, 2011 at 19:05, Todd Poynor <toddpoynor@google.com> wrote:
> On Mon, May 23, 2011 at 06:12:15PM -0500, Nishanth Menon wrote:
>> cpufreq table allocated by opp_init_cpufreq_table is better
>> freed by OPP layer itself. This allows future modifications to
>> the table handling to be transparent to the users.
> ...
>> +void opp_free_cpufreq_table(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpufreq=
_frequency_table **table)
>> +{
>> + =A0 =A0 if (!table)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 /* Pretend as if I am an updater */
>> + =A0 =A0 mutex_lock(&dev_opp_list_lock);
>> + =A0 =A0 kfree(*table);
>> + =A0 =A0 *table =3D NULL;
>> + =A0 =A0 mutex_unlock(&dev_opp_list_lock);
>> +}
>
> Not clear what the mutex protects here. =A0Currently it protects only
> device opp list modifications. =A0opp_init_cpufreq_table holds the lock o=
nly
> while looking up and walking the device opp list; the cpufreq table it
> creates is not complete by the time the lock is dropped.

hmm.. right.. mutex protection does'nt really make sense here..

Regards,
Nishanth Menon
