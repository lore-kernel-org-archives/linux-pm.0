From: Aneesh Bhasin <contact.aneesh@gmail.com>
Subject: Re: [android-porting] wakeup wakelock issues
Date: Mon, 23 Nov 2009 10:24:25 +0530
Message-ID: <f662f0210911222054u12496269u846b169dff2a730f@mail.gmail.com>
References: <8bf247760911210837y3f089eaegd57fcec21d93681b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8bf247760911210837y3f089eaegd57fcec21d93681b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: android-porting@googlegroups.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Sriram

<reposting - forgot to add linux-pm to senders' list>

On Sat, Nov 21, 2009 at 10:07 PM, Sriram V <vshrirama@gmail.com> wrote:
> Hi,
> =A0 I am trying to test pm on a custom board with android.

What android version are you usnig ?


> =A0 Whats happening:
> =A0=A0 1) Android is putting the system to sleep - calling system wide su=
spend
> =A0=A0 2) During suspend, kernel resume immediately - I get "wakeup wake =
lock:
> omap-8250-serial". and again puts it back to suspend.
> =A0=A0 3) This keeps happening, There is no serial activity except for pr=
inting
> the messages (transmission from the board) - No serial inputs from the ho=
st
> pc.
> =A0=A0 4) Is there any way to disable this?
>

We encountered a similar problem while booting android on one of our
board. One way is to acquire a partial wake lock (or just a wakelock
in the newer versions of android)  as soon as you boot up the board.
In older android version, the way was :
echo wakelock1 > /sys/android_power/acquire_partial_wake_lock
or on newer versions :
echo wakelock1 > /sys/power/wake_lock
Please check the path as I do not have access to the board right now.

Acquiring the wake lock will prevent your system from going into
sleep. However, this is a temporary solution as you still need to
figure out why is your device not able to go to sleep.

Hope that helps...

Regards,
Aneesh
