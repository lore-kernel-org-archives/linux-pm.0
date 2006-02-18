From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 1/5] [pm] Fix locking of device
	suspend/resume functions
Date: Fri, 17 Feb 2006 21:50:46 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602172145350.6792-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
	<20060217205939.573e1d0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============10194978498283813=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060217205939.573e1d0c.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============10194978498283813==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 17 Feb 2006, Andrew Morton wrote:

> Patrick Mochel <mochel@digitalimplant.org> wrote:
> >
> > This patch removes the unneeded down()/up() calls from
> >  suspend_device() and resume_device(). Those functions
> >  are already called under the dpm_sem, making this code
> >  unconditionally deadlock in SMP kernels.
>
> I've seen no reports of such deadlocks.  And I was testing swsusp on a
> 4-way this week?

Yup, I misparsed the code. Please disregard this patch.

Thanks,


	Pat

--===============10194978498283813==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============10194978498283813==--
