From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 17:10:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707031708080.8010-100000__24402.4454885677$1183497323$gmane$org@iolanthe.rowland.org>
References: <20070703202329.GA27927@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703202329.GA27927@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Jul 2007, Matthew Garrett wrote:

> See the start of this thread. It's just not clear what the freezer buys 
> us - removing it gets rid of a load of subtle issues and complexity, and 
> turns system suspend into something that looks more like runtime 
> suspend (which might then encourage people to get runtime suspend 
> right...)

No, no -- you have it exactly backwards.  Removing the freezer turns 
STR into something _less_ like runtime suspend, because it adds the 
requirement that devices must not automatically be resumed when an I/O 
request arrives.

Alan Stern
