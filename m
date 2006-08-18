From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 18 Aug 2006 09:42:35 +0400
Message-ID: <acd2a5930608172242v7ba6e7eeq8ab90ea11175ef4c@mail.gmail.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost> <20060817214031.GE6450@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060817214031.GE6450@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 8/18/06, Pavel Machek <pavel@ucw.cz> wrote:
> > Then, we will be able to use names like 'video', 'mp3', 'fast',
> > 'powersave', 'usb' to switch to the relevant operating point based on
> > configuration of the policy manager.
>
> This seems to be too specific to embedded machine.
>
> If userspace wants to work with usb and play mp3s at the same time,
> what does it do?

I guess it just defines an appropriate policy. You can call it
'usb_mp3' if you wish ;)
I don't think it's too embedded-specific.

Vitaly
