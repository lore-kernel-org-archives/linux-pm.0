From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/10] x86, olpc: Use a correct version when making up
 a battery node
Date: Sat, 23 Mar 2019 00:25:58 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1903230020270.2157@nanos.tec.linutronix.de>
References: <20190310162419.11861-1-lkundrak@v3.sk> <20190310162419.11861-5-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190310162419.11861-5-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sun, 10 Mar 2019, Lubomir Rintel wrote:

Subject prefix ...

> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. We need to use a different compatible string for the
> XO-1.5 battery.
> 
> Previously olpc_dt_fixup() used the presence od the battery node's

s/od/of/

>  
> +int olpc_dt_compatible_match(phandle node, const char *compat)
> +{
> +	char buf[64];
> +	int plen;
> +	char *p;
> +	int len;

Please coalesce variables of the same type. No point in wasting space.

	char buf[64], *p;
	int plen, len;

Hmm?

> +
> +		if (olpc_dt_compatible_match(node, "olpc,xo1-battery")) {
> +			/* If we have a olpc,xo1-battery compatible, then we're
> +			 * running a new enough firmware that already has
> +			 * the dcon node.
> +			 */

Comment style:

       		 	 /*
			  * This is a proper multi line comment even
			  * if networking people use that horrible style
			  * above.
			  */

With those nitpicks fixed:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
