From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PowerOP, PowerOP Core, 1/2
Date: Mon, 18 Sep 2006 06:23:41 -0700
Message-ID: <20060918132341.GA8854@kroah.com>
References: <45096933.4070405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45096933.4070405@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 14, 2006 at 06:37:39PM +0400, Eugeny S. Mints wrote:
> The PowerOP Core provides completely arch independent interface
> to create and control operating points which consist of arbitrary
> subset of power parameters available on a certain platform.
> Also, PowerOP Core provides optional SysFS interface to access
> operating point from userspace.

module reference count issues have still not been addressed.

thanks,

greg k-h
