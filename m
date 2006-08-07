From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: PowerOp Design and working patch
Date: Mon, 07 Aug 2006 13:34:47 +0300
Message-ID: <1154946887.11382.17.camel@Dogbert.NOE.nokia.com>
References: <c6333353f00bb7fd435ef518dc8cee21@mvista.com>
	<20060729004546.GA3917@kroah.com>
	<1c70fd37e4eb876295e0194e2b8725d6@mvista.com><44CBB1E0.3030908@gmail.com>
	<62e4476a851bbed395b509023edc5c5c@mvista.com>
	<acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
	<b04f25ff9b3eb8a48cad52ee832d5bf2@mvista.com>
	<215c230e2979117fd14d83ea2fd83054@embeddedalley.com>
	<287a694aae15b3fba505f4381c95c9c8@mvista.com><44CFA2F5.1070707@am.sony.com>
	<20060806221104.GB4205@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060806221104.GB4205@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Pavel Machek <pavel@ucw.cz>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org, david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

Hi,
On Mon, 2006-08-07 at 01:11 +0300, ext Pavel Machek wrote:
<snip>
> > Often, in the embedded world, the person defining the operating
> > states will not be a kernel developer, and may not be comfortable
> > with, or capable of, creating a kernel module.  (There are
> =

> That's okay, we can create HOWTO or something. 'System designed is too
> stupid to hack kernel' should not be an argument.

In a production environment the competence and experience is usually
distributed across several teams and it's not realistic to just label
"stupid" somebody who has a deep understanding of the HW platform but
not so good understanding of kernel internals.
> =

Once there is a clean separation between mechanism and policies, there
is no need to have a kernel developer take care of issues that are
purely HW-related.



-- =

Cheers,
           Igor

Igor Stoppa (Nokia M - OSSO / Tampere)
