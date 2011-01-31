From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] i2c: OMAP: fix static suspend vs. runtime
 suspend
Date: Mon, 31 Jan 2011 10:13:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101311010580.1931-100000__18119.0034062185$1296486846$gmane$org@iolanthe.rowland.org>
References: <1a4ad626f3cb73267847e8ac7bd47545@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1a4ad626f3cb73267847e8ac7bd47545@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 31 Jan 2011, Rajendra Nayak wrote:

> Can you elaborate a bit more on how/why runtime PM transitions
> are disabled during system suspend, and how is it taken care
> of that a runtime resume of a device works however a subsequent
> runtime (re)suspend does not?

I'll answer for Kevin.  This is done by the PM core, in order to 
prevent runtime power transitions from interfering with a system power 
transition.  The PM core increments the device's usage_count; this 
prevents the device from being runtime-suspended but it allows 
runtime-resume calls to go through.

Alan Stern
