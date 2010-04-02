From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: what the patches do Re: [RFC 10/15] PM / Hibernate:
	user, implement user_ops reader
Date: Fri, 2 Apr 2010 19:03:12 +0200
Message-ID: <201004021903.12993.rjw__28352.3157625043$1270227659$gmane$org@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<4BABDA59.8070107@crca.org.au>
	<20100402063644.GA14941@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100402063644.GA14941@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

On Friday 02 April 2010, Pavel Machek wrote:
...
> > Neither of those are impossible with in-kernel code, so I'd argue that  
> > there's no need to keep the s2disk interface long-term. Userspace  
> 
> I disagree.
> 
> > helpers might be necessary for the first one (to manage the network  
> > interface), but I already have multiple-resumes-from-the-same-image  
> > support in TuxOnice (and more 'crazy stuff' like support for resuming a  
> > different image after writing one - that can be used to switch to an  
> > initramfs containing the binaries needed to power down a UPS).
> 
> The fact that it can be done in kernel -- anything can -- but whether
> it should. I'd very much like to keep the 'crazy stuff' in userspace.

IMO the question really boils down to what's the benefit of doing these things
in the kernel vs doing them in the user space.

If doing them in the kernel reduces the overall complexity of design (including
the user space interface involved etc.) I don't really see why not to.

Rafael
