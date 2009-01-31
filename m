From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 05/11] PM: Enable early suspend through
 /sys/power/state
Date: Sat, 31 Jan 2009 10:49:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901311047280.6305-100000@netrider.rowland.org>
References: <d6200be20901301913wbb5d496wa599edddcf93674f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20901301913wbb5d496wa599edddcf93674f@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 30 Jan 2009, Arve Hj=F8nnev=E5g wrote:

> > No, please don't break compatibility like this. You changed semantics
> > of 'mem'...
> >
> > Just add another two states, for example "auto-mem" and
> > "auto-standby", and make them enter mem/standby when required.
> >
> =

> What would you want to happen if someone writes "mem"? If we just call
> enter_state, it will fail and return an error if a wakelock is locked.
> We can call request_suspend_state and then wait for another thread to
> write "on", but this still requires user-space changes to work
> correctly. If the goal is to allow the kernel to be compiled with
> wakelock and early suspend support while preserving the old behaviour
> if wakelocks are not used, then the first option is better.

This is exactly what I am complaining about in another thread.  The =

code should be written so that when the user writes "mem", the system =

goes into suspend even if some wakelocks are locked.

Alan Stern
