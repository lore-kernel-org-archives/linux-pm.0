From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 22:36:39 +0100
Message-ID: <20070703213639.GA29149__31266.2926306531$1183498765$gmane$org@srcf.ucam.org>
References: <20070703211227.GA28758@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707031713530.8010-100000@iolanthe.rowland.org>
	<20070703212002.GA28895@srcf.ucam.org>
	<200707032337.52544.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707032337.52544.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 03, 2007 at 11:37:51PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, 3 July 2007 23:20, Matthew Garrett wrote:
> > We're used to the idea of applications blocking when a resource they're 
> > using goes away - NFS has done it forever. 
> 
> Now, please tell me how many driver writers even thought that something
> might try to access their devices after .suspend() had been executed (or
> even whilie it was being executed)?

Every single driver that fails under those conditions is already broken, 
and has been forever. It's likely that they're broken under run-time 
suspend, too.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
