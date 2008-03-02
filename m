From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [RFC][PATCH] cpuidle: avoid singing capacitors
Date: Sun, 2 Mar 2008 15:17:06 +0100
Message-ID: <20080302151706.4f99dda9__39156.2510900714$1204467800$gmane$org@mjolnir.drzeus.cx>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
	<75b66ecd0803011827qd64e1f2ud593fedbec33abe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <75b66ecd0803011827qd64e1f2ud593fedbec33abe9@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 1 Mar 2008 21:27:09 -0500
"Lee Revell" <rlrevell@joe-job.com> wrote:

> 
> Should there be a comment stating the motivation for the change?

In the code you mean? Yes, that will be added.

> 
> Thanks for trying to address this problem, I know many users who are afflicted.
> 

As always, the quickest way to get things done is to make sure a kernel developer suffers from the same issue. ;)

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
