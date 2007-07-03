From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 22:12:28 +0100
Message-ID: <20070703211227.GA28758__43394.0827650533$1183497462$gmane$org@srcf.ucam.org>
References: <20070703202329.GA27927@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707031708080.8010-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0707031708080.8010-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 03, 2007 at 05:10:08PM -0400, Alan Stern wrote:

> No, no -- you have it exactly backwards.  Removing the freezer turns 
> STR into something _less_ like runtime suspend, because it adds the 
> requirement that devices must not automatically be resumed when an I/O 
> request arrives.

But that's fine - "Are we undergoing a systemwide suspend" is an easy 
question to ask. Freezing processes instead means that most of those 
paths will never be tested.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
