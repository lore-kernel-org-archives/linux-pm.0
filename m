From: Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.12-rc4] pm diagnostics update,
	check for errors
Date: Mon, 9 May 2005 10:32:22 -0700
Message-ID: <20050509173221.GC19474@kroah.com>
References: <200505081715.20470.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28014146057909883=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505081715.20470.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============28014146057909883==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 08, 2005 at 05:15:20PM -0700, David Brownell wrote:
> I've had this for a while, and converting to a GIT repository is
> incentive enough to send it out.  Mostly it just makes existing
> diagnostics be more useful, but it also adds some error checking
> for cases that can happen on non-trivial systems ... or when
> userspace actions through /sys/.../power/state files break some
> system integrity rules.
> 
> If nobody objects, I'll probably ask to merge this at some point.

No objections from me.

greg k-h

--===============28014146057909883==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28014146057909883==--
