From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH, RFC] linkstation: implement standby
Date: Mon, 27 Aug 2007 12:03:16 +0200
Message-ID: <20070827100316.GD1972@elf.ucw.cz>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun 2007-08-26 02:03:49, Guennadi Liakhovetski wrote:
> Implement suspend/resume for "mpc10x" compatible fsl host PCI controllers, 
> use it for linkstation standby.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Looks okay to me. I'm glad to see "standby" is present on non-i386
machines, too.
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
