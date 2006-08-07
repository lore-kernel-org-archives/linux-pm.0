From: Greg KH <greg@kroah.com>
Subject: Re: PowerOp Design and working patch
Date: Mon, 7 Aug 2006 09:58:41 -0700
Message-ID: <20060807165841.GB6849@kroah.com>
References: <200608071412.k77ECEQD009852@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608071412.k77ECEQD009852@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: daviado@gmail.com, linux-pm@lists.osdl.org, dsingleton@mvista.com, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


A: No.
Q: Should I include quotations after my reply?

On Mon, Aug 07, 2006 at 09:12:14AM -0500, Scott E. Preece wrote:
> =

> While I think it makes sense to treat a list as a "single value" in this
> kind of case

A simple list, like what we have today in /sys/power/state, yes.  But
with paramater information?  no.

>, a reasonable alternative would be to make /sys/power/supported_states
>a directory, with separate files for each supported OP.

Sure, if you want to do that, fine.  But then you are looking a lot like
configfs :)

thanks,

greg k-h
