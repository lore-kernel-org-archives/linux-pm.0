From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp1 not working
Date: Fri, 30 Dec 2005 15:43:26 +0100
Message-ID: <200512301543.27238.rjw@sisk.pl>
References: <380D9721A8E2114485644D71E87C6AB2012F4CFC@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94122604344891947=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB2012F4CFC@PNE-HJN-MBX01.wipro.com>
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
Cc: rasmit.ranjan@wipro.com
List-Id: linux-pm@vger.kernel.org

--===============94122604344891947==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday, 30 December 2005 05:27, rasmit.ranjan@wipro.com wrote:
> Hello,
>     i am new to linux power management system. my requirement is to put
> my system in low power mode.
> so i tried swsusp1 and suspend2. in my system suspend2 works properly.
> but i am getting problem with
> swsusp1.
> i am using linux-2.6.13.3. stpes i followed for swsusp1 are:
>     -- compiled my kernel with software suspend,power management and
> acpi enabled
>     -- added the following line to my grub.conf as kernel parameter.
>             resume=swap:/dev/hdb2     ( /dev/hdb2 is my swap partition )

Please try changing it to resume=/dev/hdb2

Greetings,
Rafael

--===============94122604344891947==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94122604344891947==--
