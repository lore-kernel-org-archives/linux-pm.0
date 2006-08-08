From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend to disk not working due to swap space failure
Date: Tue, 08 Aug 2006 15:53:07 +0200
Message-ID: <44D89743.6060505@sipsolutions.net>
References: <380D9721A8E2114485644D71E87C6AB20250B425@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB20250B425@PNE-HJN-MBX01.wipro.com>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

rasmit.ranjan@wipro.com wrote:
> So i tried creating a new
> swap space by the command " mkswap". But still my swap partition does
> not come up. I reboot my system but that did not work as well. What
> might be the problem? =

Is it listed in /etc/fstab so swapon -a can find it?

johannes
