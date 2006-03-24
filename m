From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] suspend.c: make sure stdin,
	stdout and stderr are open
Date: Fri, 24 Mar 2006 21:36:55 +0100
Message-ID: <200603242136.56180.rjw@sisk.pl>
References: <200603242013.48811.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============80785714597493086=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603242013.48811.stefan@loplof.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============80785714597493086==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday 24 March 2006 20:13, Stefan Rompf wrote:
> recently I patched my 2.6.16 kernel to use uswsusp. Nice work, but when I 
> installed /usr/local/sbin/suspend into the Suse 9.3 powermanagement scripts, 
> I've stumbled over a bad interaction: powersaved closes all filedescriptors 
> before calling scripts. suspend then opens snapshot and swap device, 
> allocating file descriptors 0 and 1, but printfs() afterwards. Luckily, I did 
> not lose any data.
> 
> For robustness, suspend must make sure that these fds are open. Simple patch 
> to achieve this is attached. It loses the descriptors, but I don't think 
> that's an issue for the short running program.

Thanks a lot for the patch, I'll have a look at it shortly.

BTW, it follows from what you said that you compiled suspend on SuSE 9.3.
Was it on i386?

Rafael

--===============80785714597493086==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============80785714597493086==--
