From: Oliver Neukum <oliver@neukum.org>
Subject: Re: power/level and power/control
Date: Fri, 12 Mar 2010 09:43:09 +0100
Message-ID: <201003120943.09520.oliver__25224.5717136704$1268383462$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.1003111139170.1367-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003111139170.1367-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, kay.sievers@vrfy.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 11. M=E4rz 2010 17:44:59 schrieb Alan Stern:
> Greg & Rafael:
> =

> In 2.6.34-rc1 we have the new /sys/devices/.../power/control attribute, =

> which does exactly the same thing as USB's existing power/level =

> attribute.
> =

> There's no reason to keep both.  I'd remove power/level entirely, =

> except that it has been in existence for a while and people may be =

> using it.
> =

> The best solution may be to replace "level" with a symbolic link to =

> "control", and possibly also to deprecate it.  Does that seem like the =

> right thing to do?

Sounds good.

Has support in user space hardware abstraction layers for runtime
power management been added? It seems to me that we need this.

	Regards
		Oliver
