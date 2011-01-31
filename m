From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] i2c: OMAP: fix static suspend vs. runtime
	suspend
Date: Mon, 31 Jan 2011 08:09:12 -0800
Message-ID: <877hdl9hsn.fsf__38907.544167205$1296490338$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Mon, 31 Jan 2011 10:13:13 -0500 (EST)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Mon, 31 Jan 2011, Rajendra Nayak wrote:
>
>> Can you elaborate a bit more on how/why runtime PM transitions
>> are disabled during system suspend, and how is it taken care
>> of that a runtime resume of a device works however a subsequent
>> runtime (re)suspend does not?
>
> I'll answer for Kevin.  This is done by the PM core, in order to 
> prevent runtime power transitions from interfering with a system power 
> transition.  The PM core increments the device's usage_count; this 
> prevents the device from being runtime-suspended but it allows 
> runtime-resume calls to go through.

I understand how this works, but frankly I'm still a bit fuzzy on why.

I guess I'm still missing a good understanding of what "interfering with a
system power transition" means, and why a runtime suspend qualifies as
interfering but not a runtime resume.

More specifically, the reason for $SUBJECT patch is precisely because a
runtime resume is allowed, a runtime suspend is not, and thus a system
power transititon is prevented.

Kevin
