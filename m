From: Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Date: Wed, 16 Aug 2006 21:40:11 -0700
Message-ID: <20060817044011.GB14127@kroah.com>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz>
	<200608161304.51758.rjw@sisk.pl> <200608161314.11128.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608161314.11128.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 16, 2006 at 01:14:11PM +0200, Rafael J. Wysocki wrote:
> Remove the CONFIG_PM_TRACE option, which is dangerous and should only be =
used
> by people who know exactly what they are doing, from Kconfig.

No, don't remove this, that's not acceptable at all.  This is useful for
others (and one specifically who will be pissed to see this removed...)

So NAK to this.

thanks,

greg k-h
