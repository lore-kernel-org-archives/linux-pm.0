From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Tue, 14 Feb 2006 16:08:58 -0500
Message-ID: <1139951339.11659.157.camel@mindpipe>
References: <Pine.LNX.4.44L0.0602141417350.1419-100000@iolanthe.rowland.org>
	<200602142141.10545.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25057714690070099=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602142141.10545.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============25057714690070099==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-02-14 at 21:41 +0100, Rafael J. Wysocki wrote:
> [BTW, I wonder if it's USB-only, or some other subsystems behave
> in a similar way, like ieee1394 or external SATA.  And how about
> NFS/CIFS/whatever network filesystems mounted on the suspending box?]
> 

NFS is stateless, it does not care about stuff like this.  There's no
concept of an open file.  write() does not return until the data is
committed to stable storage.

Lee


--===============25057714690070099==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25057714690070099==--
