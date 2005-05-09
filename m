From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Disabling Devices
Date: Mon, 9 May 2005 09:57:21 -0700
Message-ID: <200505090957.22113.david-b@pacbell.net>
References: <20050509021528.GB27448@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============19378427948587951=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050509021528.GB27448@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============19378427948587951==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 08 May 2005 7:15 pm, Adam Belay wrote:
> 
> One potentially important aspect of power management is the ability for the
> user to disable a device that he or she does not intend to use.  

I tend to agree with Alan on this:  this doesn't seem like something
that should need separate attention.

Though maybe I'm not clear on what you mean by "disable".  How would
that differ from having inactive drivers be in low power modes?

- Dave

--===============19378427948587951==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============19378427948587951==--
