From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Block on access to temporarily unavailable
	pci device [version 3]
Date: Thu, 19 Oct 2006 16:51:49 -0700
Message-ID: <20061019235149.GA5343@kroah.com>
References: <20061017145146.GJ22289@parisc-linux.org>
	<20061019154128.GD2602@parisc-linux.org>
	<1161299636.16080.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1161299636.16080.17.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@MIT.EDU>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 19, 2006 at 07:13:56PM -0400, Adam Belay wrote:
> It would be nice if we had sysfs expose struct file at some point... :)

No it would not.  I have yet to see a valid reason why to do this
(everyone would be abusing sysfs even worse if it was present, you
should see some of the requests I've had over the years...)

thanks,

greg k-h
