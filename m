From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: Re: [linux-pm] [RFC 1/4] cpuidle: define the enter function in the
	driver structure
Date: Wed, 13 Jun 2012 14:44:55 +0200
Message-ID: <CAORVsuXEkyU_OkjqLDhe_OMq-uLEBaMLnz-pkJ1jtgnmcNxZpw@mail.gmail.com>
References: <1339171365-4098-1-git-send-email-daniel.lezcano@linaro.org>
	<4FD23752.6090101@linux.vnet.ibm.com> <4FD27000.7000208@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4FD27000.7000208-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Deepthi Dharwar <deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Fri, Jun 8, 2012 at 11:34 PM, Daniel Lezcano
<daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 06/08/2012 07:33 PM, Deepthi Dharwar wrote:
>> Hi Daniel,
>
> Hi Deepthi,
>
>> On 06/08/2012 09:32 PM, Daniel Lezcano wrote:
>>
>>> We have the state index passed as parameter to the 'enter' function.
>>> Most of the drivers assign their 'enter' functions several times in
>>> the cpuidle_state structure, as we have the index, we can delegate
>>> to the driver to handle their own callback array.
>>>
>>> That will have the benefit of removing multiple lines of code in the
>>> different drivers.
>>>
>>> In order to smoothly modify the driver, the 'enter' function are in
>>> the driver structure and in the cpuidle state structure. That will
>>> let the time to modify the different drivers one by one.
>>> So the 'cpuidle_enter' function checks if the 'enter' callback is
>>> assigned in the driver structure and use it, otherwise it invokes
>>> the 'enter' assigned to the cpuidle_state.
>>
>>
>> Currently, the backend driver initializes
>> all the cpuidle states supported on the platform,
>> and each state can have its own enter routine
>> which can be unique This is a clean approach.
>
> Yes, I perfectly understood the purpose of this field but as clean it is
> it does not make sense as it is not used in this way. If it is supposed
> to be done in the way you are describing here, we should have the same
> number of states and enter functions. Here it is how it is used:
>
> =A0--------------------------------------------------
> | Arch =A0 =A0 =A0 =A0 =A0 =A0 | nr states | nr enter function |
> =A0--------------------------------------------------
> | x86 (nehalem) =A0 =A0| =A0 =A03 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =A0 =
=A0 =A0 |
> =A0--------------------------------------------------
> | x86 (snb) =A0 =A0 =A0 =A0| =A0 =A04 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | x86 (atom) =A0 =A0 =A0 | =A0 =A04 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | ARM tegra =A0 =A0 =A0 =A0| =A0 =A01 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | ARM omap3 =A0 =A0 =A0 =A0| =A0 =A07 =A0 =A0 =A0| =A0 =A0 =A0 =A0 2 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | ARM omap4 =A0 =A0 =A0 =A0| =A0 =A03 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | ARM ux500 =A0 =A0 =A0 =A0| =A0 =A02 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | ARM shmobile =A0 =A0 | =A0 =A01 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =A0 =
=A0 =A0 |
> =A0--------------------------------------------------
> | ARM davinci =A0 =A0 =A0| =A0 =A02 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | ARM at91 =A0 =A0 =A0 =A0 | =A0 =A02 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | ARM s3c64xx =A0 =A0 =A0| =A0 =A01 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | ARM exynos =A0 =A0 =A0 | =A0 =A02 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =
=A0 =A0 =A0 |
> =A0--------------------------------------------------
> | ARM kirkwood =A0 =A0 | =A0 =A02 =A0 =A0 =A0| =A0 =A0 =A0 =A0 1 =A0 =A0 =
=A0 =A0 |
> =A0--------------------------------------------------
> | SH =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =
1 =A0 =A0 =A0 =A0 |
> =A0--------------------------------------------------
> | PPC =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =
2 =A0 =A0 =A0 =A0 |
> =A0--------------------------------------------------
> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> | TOTAL =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A039 =A0 =A0 | =A0 =A0 =A0 =A017 =
=A0 =A0 =A0 =A0 |
> | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> =A0--------------------------------------------------
>
>
> As you can see most of the enter functions are only used as one.
> The Omap3 cpuidle driver enter function for C2 calls the enter function
> of C1. Other arch, already use a table of callbacks or the index.
There is a plan to remove the extra enter function as part of an
optimization, cf. [1]. The fix is planned to reach the 3.6 mainline
kernel via Kevin's tree [2].

[1] http://marc.info/?l=3Dlinux-omap&m=3D133856365818099&w=3D2
[2] http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git;a=
=3Dshortlog;h=3Drefs/heads/for_3.6/pm/performance

The result is that there will be only one enter function for OMAP3.

Regards,
Jean

>> By moving the enter routine into the driver,
>> we are enforcing in having only one enter state.
>> There is unnecessary overhead involved
>> in calling a wrapper routine just to
>> index into the right idle state routine
>> for many platforms at runtime.
>
> I don't agree. For the sake of encapsulated code, we duplicate n-times a
> field and that is not used in this way. It is quite easy to have in the
> driver specific code a common enter function to ventilate to the right
> routine without adding extra overhead and let the common code use a
> single enter routine (which is already the case today).
>
>
> _______________________________________________
> linux-pm mailing list
> linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
