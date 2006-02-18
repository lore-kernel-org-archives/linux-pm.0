From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/5] [pm] Fix locking of device
	suspend/resume functions
Date: Fri, 17 Feb 2006 20:59:39 -0800
Message-ID: <20060217205939.573e1d0c.akpm@osdl.org>
References: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============024007465254916038=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============024007465254916038==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Patrick Mochel <mochel@digitalimplant.org> wrote:
>
> This patch removes the unneeded down()/up() calls from
>  suspend_device() and resume_device(). Those functions
>  are already called under the dpm_sem, making this code
>  unconditionally deadlock in SMP kernels.

I've seen no reports of such deadlocks.  And I was testing swsusp on a
4-way this week?


--===============024007465254916038==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============024007465254916038==--
