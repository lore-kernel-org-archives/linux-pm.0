From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] Complain if driver reenables interrupts
	during drivers_[suspend|resume] & re-disable
Date: Wed, 8 Feb 2006 00:40:40 -0500
Message-ID: <200602080040.41495.dtor_core@ameritech.net>
References: <200602071906.55281.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============13416693988941431=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602071906.55281.ncunningham@cyclades.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============13416693988941431==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 07 February 2006 04:06, Nigel Cunningham wrote:
> Hi all.
> 
> This patch is designed to help with diagnosing and fixing the cause of
> problems in suspending/resuming, due to drivers wrongly re-enabling
> interrupts in their .suspend or .resume methods. 
> 
> I nearly forgot about it in sending patches in suspend2 that might help
> where swsusp fails.
> 

Only sysdevs are guaranteed to be suspebded/resumed with interrupts off,
other devices are suspended with interrupts on (at least on first pass
over device list).

-- 
Dmitry

--===============13416693988941431==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============13416693988941431==--
