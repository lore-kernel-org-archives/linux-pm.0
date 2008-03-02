From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [RFC][PATCH] cpuidle: avoid singing capacitors
Date: Sat, 1 Mar 2008 21:27:09 -0500
Message-ID: <75b66ecd0803011827qd64e1f2ud593fedbec33abe9__9377.99651078439$1204560753$gmane$org@mail.gmail.com>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 29, 2008 at 1:38 PM, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Many devices today are of a less than stellar quality, and singing
>  transistors are a common problem. A high-pitch noise is created, caused
>  by power fluctuations as the processor enters and leaves deep sleep at
>  a high frequency.
>
>  Instead of just disabling the deep sleep (which wastes power). This
>  patch merely reduces the number of times it is entered so that the
>  frequency doesn't exceed 500 Hz. That should make sure the problem is
>  inaudible.

Should there be a comment stating the motivation for the change?

Thanks for trying to address this problem, I know many users who are afflicted.

Lee
