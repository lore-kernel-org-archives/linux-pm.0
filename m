From: Pavel Machek <pavel@suse.cz>
Subject: Re: Using memcpy() in kernel space( driver)
Date: Thu, 4 May 2006 09:59:00 +0000
Message-ID: <20060504095900.GD5844@ucw.cz>
References: <380D9721A8E2114485644D71E87C6AB201CCBC72@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============58516277922168847=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB201CCBC72@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-kernel-digest@lists.us.dell.com, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============58516277922168847==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 04-05-06 11:35:13, rasmit.ranjan@wipro.com wrote:
> Hi all,
>     I am using memcpy() in my driver.
> I am taking a spinlock and calling this function memcpy().
> Is it safe to call memcpy() inside a lock?
> If memcpy() fails, then will it create any problem in releasing the
> spinlock ?
> Please suggest.

This is linux-PowerManagement, not linux-HELPME or linux-newbies list,
so this is offtopic here.

Uff, and your question certainly has nothing to do with usb. Pleasw
behave yourself.
							Pavel

-- 
Thanks, Sharp!

--===============58516277922168847==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============58516277922168847==--
