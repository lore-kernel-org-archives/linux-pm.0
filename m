From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 13:38:34 +1000
Message-ID: <18059.5690.908102.273897__48703.2964396805$1183525825$gmane$org@cargo.ozlabs.ibm.com>
References: <20070703211227.GA28758@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707031713530.8010-100000@iolanthe.rowland.org>
	<20070703212002.GA28895@srcf.ucam.org>
	<200707032337.52544.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki writes:

> Now, please tell me how many driver writers even thought that something
> might try to access their devices after .suspend() had been executed (or
> even whilie it was being executed)?

Well, I believe that the USB framework copes with this, except
possibly for some corner cases like the example that Alan Stern
posted.  The fact that powerbooks suspend and resume without the
freezer implies that the IDE framework, the console code and the
framebuffer code cope correctly (though possibly not all chipset
drivers).

So I think that a lot of the frameworks already get it right.  Of
course the quality of the low-level chipset drivers has always been
pretty variable. :)

Paul.
