From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Runtime PM discussion notes
Date: Fri, 24 Jun 2011 15:27:03 -0700
Message-ID: <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw__5474.08637726239$1308954492$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<201106232234.21930.rjw@sisk.pl>
	<alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 24, 2011 at 12:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
...
>
> As I understand it, in the original Android implementation, the hardware
> that they were using didn't have fine-grained power management. =A0So
> system-wide suspend made more sense in that context. =A0But that shouldn't
> be confused with the modern rationale for wakelocks:
>
> https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668.html
>
> "On the hardware that shipped we enter the same power state from idle
> and suspend, so the only power savings we get from suspend that we
> don't get in idle is from not respecting the scheduler and timers."
>

This is no longer the case. Both the Nexus-S and Xoom enter lower
power states from suspend than idle.

-- =

Arve Hj=F8nnev=E5g
