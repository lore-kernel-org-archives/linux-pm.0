From: David Brownell <david-b@pacbell.net>
Subject: Re: /sys/power/state contents
Date: Mon, 1 May 2006 15:31:00 -0700
Message-ID: <200605011531.00656.david-b@pacbell.net>
References: <1146300258.5019.16.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============62526405861169287=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1146300258.5019.16.camel@localhost>
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
List-Id: linux-pm@vger.kernel.org

--===============62526405861169287==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 29 April 2006 1:44 am, Johannes Berg wrote:
> Why does it say:
>  *      show() returns what states are supported, which is hard-coded to
>  *      'standby' (Power-On Suspend), 'mem' (Suspend-to-RAM), and
>  *      'disk' (Suspend-to-Disk).
> 
> and not use the ->valid call to limit what is displayed to what can be
> entered?

You mean, exactly like the valid_state() function already does??

--===============62526405861169287==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============62526405861169287==--
