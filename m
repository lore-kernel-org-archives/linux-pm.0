From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sun, 08 Jul 2007 10:40:46 +1000
Message-ID: <1183855247.3388.231.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707061034540.3737-100000@iolanthe.rowland.org>
	<1183779845.3388.206.camel@localhost.localdomain>
	<20070707114917.GC2789@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070707114917.GC2789@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2007-07-07 at 13:49 +0200, Pavel Machek wrote:

> And anyway I believe that current issue (fuse deadlocks with s2ram)
> should be present on powerbooks, too... it is just way harder to
> trigger. All that is neccessary is fused (or one of its helpers) to
> get frozen by accessing suspended device.

I don't see any fuse specific issue without a freezer, but I see generic
issues such as kmalloc blocking in a driver with a mutex held etc... but
I've talked about these already. They have nothing to do with the
freezer though.

Ben.
