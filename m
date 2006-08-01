From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: PowerOp Design and working patch
Date: Tue, 1 Aug 2006 23:17:47 +0400
Message-ID: <acd2a5930608011217v5537a238nfdb4b868a2d43252@mail.gmail.com>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
	<44CBB1E0.3030908@gmail.com>
	<62e4476a851bbed395b509023edc5c5c@mvista.com>
	<acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
	<b04f25ff9b3eb8a48cad52ee832d5bf2@mvista.com>
	<215c230e2979117fd14d83ea2fd83054@embeddedalley.com>
	<287a694aae15b3fba505f4381c95c9c8@mvista.com>
	<44CFA2F5.1070707@am.sony.com>
	<b76ca42c0266ee8e01215a7a56ed7269@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <b76ca42c0266ee8e01215a7a56ed7269@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david singleton <dsingleton@mvista.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> > Would not the normal Unix permissions system prevent the
> > "bad state" problem, in the non-embedded case?
>
> Not necessarily, the problem occurs when the user (root even)
> passes in a frequency or voltage that isn't quite supported.  The value
> passes the ranges checks but when the clocks are set to the passed
> value the voltage is just below the edge where things still work. The
> system gets into an undefined state and usually hangs.  This is the
> most common problem we have today with the Dynamic Power
> Management solution.

Oops.
That's the problem of *BAD* restrictions, and not of the approach.

Vitaly
