From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 01:45:50 +0100
Message-ID: <20070711004549.GA30249__20535.4624464691$1184114845$gmane$org@srcf.ucam.org>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707101245.31449.nigel@nigel.suspend2.net>
	<200707100951.04193.david-b@pacbell.net>
	<200707110816.42114.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707110816.42114.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: rtc-linux@googlegroups.com, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 11, 2007 at 08:16:40AM +1000, Nigel Cunningham wrote:
> Yeah, the bit I consider to be ugly is opening the files from within the 
> kernel, but it seemed to be necessary in order to provide the functionality 
> without having to rely on userspace or do some sort of messy work to figure 
> out how to access the lid button and so on.

How are you going to shift into suspend to disk without going via 
userspace? It's quite plausible that people will want different 
configuration at that point (or, realistically, need a different set of 
workarounds...)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
