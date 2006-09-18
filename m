From: Greg KH <greg@kroah.com>
Subject: Re: PowerOP summary
Date: Mon, 18 Sep 2006 06:39:49 -0700
Message-ID: <20060918133949.GA9495@kroah.com>
References: <330177f4f8f83d0d39034c8f05d4b1f7@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <330177f4f8f83d0d39034c8f05d4b1f7@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: pm list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 14, 2006 at 01:28:25AM -0700, Matthew Locke wrote:
> Summary
> PowerOP is an interface to create and select operating points.  =

> Operating points are a collection of platform specific system =

> parameters (ie not i/o devices) that affect power consumption.  These =

> parameters include cpu frequency, voltages, clock sources and dividers =

> and others.  PowerOP provides a platform independent interface to =

> control these platform specific parameters.   This interface is a basic =

> building block of a power management stack for advanced power =

> management on embedded mobile devices.

Will this also work properly for 2/4/8/16/512/1024 processor machines?
They also need this kind of capability, and can not be ignored.

thanks,

greg k-h
