From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2]
	PM:	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 15:30:23 +0100
Message-ID: <20090608143023.GA16752__22924.0168155686$1244471480$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<20090608131159.GA15100@srcf.ucam.org>
	<20090608132235.GC13214@elte.hu>
	<200906081539.20459.oliver@neukum.org>
	<20090608142154.GD14234@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090608142154.GD14234@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 08, 2009 at 04:21:54PM +0200, Ingo Molnar wrote:

> The kernel _needs_ to have precise information about whether a piece 
> of hardware is in use or not.

The kernel can only have that information if userspace tells it. What 
we're quibbling over is whether the kernel should be explicitly told 
about the requirement (ie, every time an app makes a key grab in X the 
kernel gets told about it) or whether it should be implicit (userspace 
knows that a key grab has been made and so requests that the keyboard 
not be suspended).

We *can* put all of that complexity in the kernel. The question is 
whether it buys us anything. We'd have to modify huge chunks of 
userspace and in the process we'd end up limited to whatever policy 
happens to exist in the version of the kernel the user is running.

I'd like the kernel to expose this functionality but leave the policy 
decisions to userland.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
