From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: simpler calculation of number of pages
	in PBE list
Date: Fri, 29 Jul 2005 23:53:38 +0200
Message-ID: <200507292353.39282.rjw@sisk.pl>
References: <42EA87A0.908@stud.feec.vutbr.cz> <200507292243.28276.rjw@sisk.pl>
	<42EA9C38.90905@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96167922699261599=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <42EA9C38.90905@stud.feec.vutbr.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============96167922699261599==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, 29 of July 2005 23:14, Michal Schmidt wrote:
> Rafael J. Wysocki wrote:
> > On Friday, 29 of July 2005 21:46, Michal Schmidt wrote:
> > 
> >>The function calc_nr uses an iterative algorithm to calculate the number 
> >>of pages needed for the image and the pagedir. Exactly the same result 
> >>can be obtained with a one-line expression.
> > 
> > 
> > Could you please post the proof?
> > 
> > Rafael
> 
> OK, attached is a proof-by-brute-force program. It compares the results 
> of the original function and the simplified one.
> 
> This is its output:
> 
> $ ./calc_nr2
> checked 0 ...
> checked 100000000 ...
> checked 200000000 ...
> checked 300000000 ...
> checked 400000000 ...
> checked 500000000 ...
> checked 600000000 ...
> checked 700000000 ...
> checked 800000000 ...
> checked 900000000 ...
> checked 1000000000 ...
> checked 1100000000 ...
> checked 1200000000 ...
> checked 1300000000 ...
> checked 1400000000 ...
> checked 1500000000 ...
> checked 1600000000 ...
> checked 1700000000 ...
> checked 1800000000 ...
> checked 1900000000 ...
> checked 2000000000 ...
> checked 2100000000 ...
> First difference at 2130706433:  -2147483646 x -2147483647
> 
> It means that the two functions give the same results for sensible 
> values of the input argument.
> They results only differ when they overflow into negative values. At 
> this point both of the results are useless.

Thanks, fine. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============96167922699261599==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96167922699261599==--
