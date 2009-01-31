From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 05/11] PM: Enable early suspend through
	/sys/power/state
Date: Fri, 30 Jan 2009 19:13:32 -0800
Message-ID: <d6200be20901301913wbb5d496wa599edddcf93674f@mail.gmail.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-2-git-send-email-arve@android.com>
	<1231896476-22445-3-git-send-email-arve@android.com>
	<1231896476-22445-4-git-send-email-arve@android.com>
	<1231896476-22445-5-git-send-email-arve@android.com>
	<1231896476-22445-6-git-send-email-arve@android.com>
	<20090128193409.GC1222@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090128193409.GC1222@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 28, 2009 at 11:34 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> If EARLYSUSPEND is enabled then writes to /sys/power/state no longer
>> blocks, and the kernel will try to enter the requested state every
>> time no wakelocks are held. Write "on" to resume normal operation.
>
> No, please don't break compatibility like this. You changed semantics
> of 'mem'...
>
> Just add another two states, for example "auto-mem" and
> "auto-standby", and make them enter mem/standby when required.
>

What would you want to happen if someone writes "mem"? If we just call
enter_state, it will fail and return an error if a wakelock is locked.
We can call request_suspend_state and then wait for another thread to
write "on", but this still requires user-space changes to work
correctly. If the goal is to allow the kernel to be compiled with
wakelock and early suspend support while preserving the old behaviour
if wakelocks are not used, then the first option is better.

-- =

Arve Hj=F8nnev=E5g
