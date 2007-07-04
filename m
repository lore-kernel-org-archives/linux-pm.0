From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 19:21:23 +1000
Message-ID: <18059.26259.765791.62319__488.061880651181$1183541247$gmane$org@cargo.ozlabs.ibm.com>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041011.33279.oliver@neukum.org>
	<18059.23015.860618.268754@cargo.ozlabs.ibm.com>
	<200707041039.30015.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041039.30015.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Oliver Neukum writes:

> > It's not lost, it's sitting in RAM, and will be sent out when you
> > resume.
> 
> Unfortunately this is not the case. The URB will error out.

So the higher-level driver needs to do the sensible thing, i.e.,
resubmit the URB after resume.  It's not rocket science.  The data is
not lost, it's sitting in RAM, and the higher-level driver will send
it out when you resume.  If not, then we fix the higher-level driver.

Of course with USB there is the interesting question of whether the
device is still there when we resume.  But if it isn't, the situation
is no different to the user asynchronously unplugging the device
during operation, and if we lose data in that situation, we can only
blame the user. :)

Paul.
