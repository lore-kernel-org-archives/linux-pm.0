From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 14:48:59 +0100
Message-ID: <200703221449.00225.oneukum@suse.de>
References: <200703221339.l2MDdejg007459@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221339.l2MDdejg007459@olwen.urbana.css.mot.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 22. M=E4rz 2007 14:39 schrieb Scott E. Preece:
> There's nothing contrived or corner-case-ish about cyclic operations in
> a world where media players, animations, etc., are utterly commonplace.
> And latency may be ignorable in a laptop environment, but it absolutely
> isn't in embedded devices, which users expect to operate immediately, as
> though they were gear-driven rather than computer-driven.

USB currently uses a delay and a switch in sysfs. Devices that have
several power saving levels would also need an attribute to specify that.
Is that acceptable?

	Regards
		Oliver
