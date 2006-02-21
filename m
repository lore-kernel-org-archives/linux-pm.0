From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/4] Fix runtime device suspend/resumre
	interface
Date: Tue, 21 Feb 2006 09:49:50 -0800
Message-ID: <20060221174950.GA23054@kroah.com>
References: <Pine.LNX.4.50.0602201641380.21145-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89264325604214256=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602201641380.21145-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, linux-pm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============89264325604214256==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 20, 2006 at 04:55:34PM -0800, Patrick Mochel wrote:
> 
> Hi there,
> 
> Here is an updated version of the patches to fix the sysfs interface for
> runtime device power management by restoring the file to its originally
> designed behavior - to place devices in the power state specified by the
> user process writing to the file.
> 
> Recently, the interface was changed to filter out values to prevent a
> BUG() that was introduced in the PCI power management code. While a valid
> fix, it makes the driver core filter values that might otherwise be used
> by the bus/device drivers.

Are there any existing bus/device drivers that are currently broken
because of this change?

thanks,

greg k-h

--===============89264325604214256==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89264325604214256==--
