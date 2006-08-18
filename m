From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 18 Aug 2006 14:48:39 +0300
Message-ID: <1155901719.3659.43.camel@localhost>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost>  <20060817214031.GE6450@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060817214031.GE6450@ucw.cz>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2006-08-17 at 21:40 +0000, ext Pavel Machek wrote:
 =

> > The userspace interface in Eungeny's patches is for other userspace
> > programs (policy managers) to activate/deactivate valid operating points
> > in the system dynamically and if necessary, introduce new ones into the
> > system. It will also allow the operating points to be referenced by name
> > instead of the tuple.
> > =

> > Then, we will be able to use names like 'video', 'mp3', 'fast',
> > 'powersave', 'usb' to switch to the relevant operating point based on
> > configuration of the policy manager.
> =

> This seems to be too specific to embedded machine.
> =

> If userspace wants to work with usb and play mp3s at the same time,
> what does it do?

Switch to 'fast'?

The operating point for a use-case specifies the _minimum_ required for
the use-case. You can always go up.

The system designer is responsible for 'designing' operating points that
take into account multiple use-cases. Designing here refers to mapping
use-cases to HW operating points.

Consider an example system with a main CPU and a DSP. To simplify
discussion, lets assume 3 levels for CPU and DSP speeds and system
voltage. Then, here is what an example operating-point to use-case
mapping table could look like:

#     CPU speed      DSP speed      Voltage       use-case
----------------------------------------------------------
1.    high           high           high          fast, video
2.    med            high           high          =

3.    med            med            med           usb[1]
4.    low            med            med           mp3
5.    low            low            low           powersave

[1] USB has voltage constraint (voltage >=3D med)

Mapping
=3D=3D=3D=3D=3D=3D=3D
Performance related: fast, video, mp3
Power related: powersave
Miscellaneous: usb

- Now if we are playing mp3, we switch to OP 4.
- Add usb and we switch to OP 3.
- Now our performance monitor (e.g load avg) indicates that we need more
CPU processing. So we switch to OP 2.

Regards,
Amit

-- =

Amit Kucheria <amit.kucheria@nokia.com>
Nokia
