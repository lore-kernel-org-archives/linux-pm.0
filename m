From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sysdev suspend/resume
Date: Tue, 26 Jul 2005 12:14:10 +0200
Message-ID: <20050726101409.GA1950@openzaurus.ucw.cz>
References: <1122356554.5479.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65781904725578921=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1122356554.5479.4.camel@linux-hp.sh.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============65781904725578921==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> The return value of sysdev's suspend/resume methods is ignored, is this
> intended (it should not fail?) or just a bug? I'd like to abort the
> suspend process if one device fails.

I guess patch would be accepted... but please make sure you test those
error paths, and printk name of failing driver.

Hmmm, I wonder how you are going to handle resume failure? AFAICS, there's
no sane way to handle that.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============65781904725578921==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65781904725578921==--
