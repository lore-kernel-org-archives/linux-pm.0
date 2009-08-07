From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 00/05] PM: Runtime PM v13 for Platform
	Devices 20090807
Date: Fri, 7 Aug 2009 10:32:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908071024370.2886-100000@iolanthe.rowland.org>
References: <20090807073315.22479.89012.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090807073315.22479.89012.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

On Fri, 7 Aug 2009, Magnus Damm wrote:

> PM: Runtime PM v13 for Platform Devices 20090807
> 
> [PATCH 01/05] PM: Runtime PM v13 - add dev_pm_ops helpers

This patch doesn't do anything much, besides reverting a change I asked 
Rafael to make.  I don't see how it helps platform-specific code do 
anything.

> [PATCH 02/05] PM: Runtime PM v13 - let bus-less devices succeed

This could be added without 01/05.  But why do you want it?  Busless
devices don't have PM runtime callbacks, so whether the core thinks the
callbacks succeed or not doesn't make any difference.

You say that "Runtime suspend and resume of devices on the platform bus
is impossible without this change", but you don't explain why -- or why
the patch makes runtime suspend and resume of these devices possible.

> [PATCH 03/05] PM: Runtime PM v13 - add debug printouts

This looks good.

> [PATCH 04/05] PM: Runtime PM v13 - CONFIG_PM_SLEEP=n support

This isn't needed at all; equivalent functionality is already present 
in v13 of Runtime PM.

> [PATCH 05/05] PM: Runtime PM v13 - platform device bus support

This doesn't affect the Runtime PM patch, so it shouldn't be rolled in 
with it.  They should remain separate.

Alan Stern
