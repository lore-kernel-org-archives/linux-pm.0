From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: simpler calculation of number of pages
	in PBE list
Date: Fri, 29 Jul 2005 22:43:27 +0200
Message-ID: <200507292243.28276.rjw@sisk.pl>
References: <42EA87A0.908@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============61113787439407985=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <42EA87A0.908@stud.feec.vutbr.cz>
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
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============61113787439407985==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, 29 of July 2005 21:46, Michal Schmidt wrote:
> The function calc_nr uses an iterative algorithm to calculate the number 
> of pages needed for the image and the pagedir. Exactly the same result 
> can be obtained with a one-line expression.

Could you please post the proof?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============61113787439407985==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============61113787439407985==--
