From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 0/6] rtc framework: remove class_device,
	use class suspend()/resume()
Date: Thu, 22 Feb 2007 14:21:36 -0800
Message-ID: <200702221421.37768.david-b@pacbell.net>
References: <200702211945.15003.david-b@pacbell.net>
	<200702221244.32442.david-b@pacbell.net>
	<20070222223758.55fce4b3@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070222223758.55fce4b3@inspiron>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com, john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 February 2007 1:37 pm, Alessandro Zummo wro
>  Hi David,
> =

>   thanks for your work. The interface system was originally
>  in place because it seemed the right-thing-to-do. if it isn't,
>  better to remove it ;)

The Right Thing may also have changed a bit over time!

- Dave
