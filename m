From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Wed, 16 Mar 2005 13:09:33 -0800
Message-ID: <200503161309.34142.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503161024360.1040-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89296233653490908=="
In-Reply-To: <Pine.LNX.4.44L0.0503161024360.1040-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============89296233653490908==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 16 March 2005 7:45 am, Alan Stern wrote:
> On Wed, 16 Mar 2005, Bernard Blackham wrote:
>
> > I haven't tried David's patch yet - the only differences are it
> > seems to use a slightly different order, and also calls
> > pci_set_master. I'll give that a spin later today combined with and
> > without yours to see what works reliably.
> 
> The missing pci_set_master in my patch probably explains the errors you 
> got.
> 
> David's patch doesn't make all the necessary changes that my patch does.  
> In particular it doesn't avoid doing pci_restore_state when there was no
> prior pci_save_state, so it will continue to exhibit some of the problems
> we were seeing before.

Well, as I said it wasn't quite ready for prime time.  It's possible that
would explain some other USB related resume issues.

I'm not sure why your patch is so big/complex t hough...

--===============89296233653490908==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89296233653490908==--
