From: Greg KH <greg@kroah.com>
Subject: Re: PowerOP, Whatchanged/Issues/TODO 2/2
Date: Sat, 2 Sep 2006 11:33:51 -0700
Message-ID: <20060902183351.GC31197@kroah.com>
References: <44F9A031.8020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44F9A031.8020203@gmail.com>
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
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 02, 2006 at 07:16:01PM +0400, Eugeny S. Mints wrote:
> whatchanged:
> - optional sysfs interface is added
> - code is moved under kernel/power
> - Greg's comments on kobject and coding style are addressed
> =

> todo/issues:
> - better implementation for getting registered operating point names
> - move string parsing into powerop generic code
> - configfs for operating points creation from user space

You forgot:
  - Handle module referencing counting issues.

Also, no #ifdefs in the .c code please, that debugging stuff doesn't
have to look like that, break it out into separate functions to keep the
codepath clean.

thanks,

greg k-h
