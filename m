From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 12:42:59 +0200
Message-ID: <200707041242.59552.rjw@sisk.pl>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707032337.52544.rjw@sisk.pl>
	<18059.5690.908102.273897@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.5690.908102.273897@cargo.ozlabs.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 05:38, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > Now, please tell me how many driver writers even thought that something
> > might try to access their devices after .suspend() had been executed (or
> > even whilie it was being executed)?
> 
> Well, I believe that the USB framework copes with this, except
> possibly for some corner cases like the example that Alan Stern
> posted.  The fact that powerbooks suspend and resume without the
> freezer implies that the IDE framework, the console code and the
> framebuffer code cope correctly (though possibly not all chipset
> drivers).

Okay, so in fact you don't know.

And that's my point in this thread.

I won't fight for the freezer for what it's worth, but let's do things in the
_right_ _order_.  For example, let's make sure that by making the $subject
change we won't introduce (too many) regressions and fix the frameworks
that don't get it right.

Using the problems with FUSE as an argument for making this change immediately
doesn't seem to be right to me.

> So I think that a lot of the frameworks already get it right.  Of
> course the quality of the low-level chipset drivers has always been
> pretty variable. :)

Yes, but that's another issue.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
