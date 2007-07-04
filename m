From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 20:46:10 +1000
Message-ID: <18059.31346.806801.871454@cargo.ozlabs.ibm.com>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041039.30015.oliver@neukum.org>
	<18059.26259.765791.62319@cargo.ozlabs.ibm.com>
	<200707041208.40735.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041208.40735.oliver@neukum.org>
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

> You cannot simply restart the URB without thinking.
> The device after resumption may or may not be in the stage
> you left it. It needs to be rechecked and some settings must be
> renewed. You cannot simple throw an URB from an arbitrary
> stage of the protocol at it.
> Suspension of devices can only happen at some points
> in the protocol.

Yeah, and?

I said "the higher-level driver needs to do the sensible thing".

Paul.
