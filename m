From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 09:46:07 -0800
Message-ID: <200503240946.08026.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503241149000.1345-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503240904570.13683-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============53319902948271114=="
In-Reply-To: <Pine.LNX.4.50.0503240904570.13683-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============53319902948271114==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 24 March 2005 9:13 am, Patrick Mochel wrote:
> 
> On Thu, 24 Mar 2005, Alan Stern wrote:
>
> >
> > A large part of the concept is already coded up and part of the kernel
> > since about 2.6.9, and it works quite well.  Its scope is currently
> > restricted to the USB layer; I'm proposing to make it more general.
> 
> Really? And it works well? Greg, David? What do you guys think of it?

USB locking keeps tripping over the driver model.  At all levels,
including driver binding, device configuration, port reset, remote
wakeup, disconnect processing, and suspend/resume.  The bus rwsem
has been particularly troublesome for tree and subtree operations
(which include most of those operations I listed).

I'll be interested to hear Alan's feedback on your proposed patches.
We've kind of taken turns butting heads against the driver model,
and he's freshest.

By the way, a lock hierarchy isn't an O(N) proposition unless you're
aiming to acquire extra locks (wholesale).

- Dave

> > In fact at this stage it's more a matter for discussion under the topic
> > of driver-model development, so I'm going to stop talking about it on
> > linux-pm.  You indicated that you had some relevant driver-model patches
> > -- would you like to send them to me?
> 
> I apologize, I assumed you had seen them. You can find them here:
> 
> http://article.gmane.org/gmane.linux.kernel/289092
> 
> specifically the klist patch:
> 
> http://article.gmane.org/gmane.linux.kernel/289090
> 
> 
> 	Pat
> 

--===============53319902948271114==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============53319902948271114==--
