From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
 all devices early (was: Re: EeePC resume failure - timers)
Date: Tue, 20 Jan 2009 15:56:01 +1100 (EST)
Message-ID: <alpine.LFD.2.00.0901201342510.3554__43610.9197246425$1232427796$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0901200850560.3081@localhost.localdomain>
	<alpine.LFD.2.00.0901200917320.2930@localhost.localdomain>
	<200901191421.56148.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901191421.56148.jbarnes@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 19 Jan 2009, Jesse Barnes wrote:
> 
> Is i915 loaded?  Hopefully you can suspend/resume in text mode using its 
> suspend/resume code w/o using the s3_bios stuff?

You're right, that works fine. So text-mode suspends and (immediately) 
resumes without any issues, multiple times. But X doesn't. The second 
resume will just hang when X re-initializes (sometimes I see the cursor, 
so I know X actually started up)

			Linus
