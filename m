From: Shaohua Li <shaohua.li@intel.com>
Subject: sysdev suspend/resume
Date: Tue, 26 Jul 2005 13:42:34 +0800
Message-ID: <1122356554.5479.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============93840755165153744=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============93840755165153744==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
The return value of sysdev's suspend/resume methods is ignored, is this
intended (it should not fail?) or just a bug? I'd like to abort the
suspend process if one device fails.

Thanks,
Shaohua


--===============93840755165153744==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============93840755165153744==--
