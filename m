From: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Subject: Re: Re: Oops 2.6.14-rc1, AMD Sempton
Date: Thu, 22 Sep 2005 22:12:01 +0200
Message-ID: <200509222212.01814.Rafal.Wysocki@fuw.edu.pl>
References: <43289FAF.5040009@iliana.nl> <432EDCDC.9070605@iliana.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <432EDCDC.9070605@iliana.nl>
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
To: linux-pm@lists.osdl.org
Cc: Joost Witteveen <joostje@iliana.nl>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 19 of September 2005 17:44, Joost Witteveen wrote:
> Joost Witteveen wrote:
> 
> > The Oops below happend while swsuspending my Sempron laptop. The 
> > system freezes afterwards.
> 
> OK, replying to my own email as I haven't had any reply yet (I'm not 
> subscribed to the list).
> 
> Since I sent the email, I've had two more oopses (they don't happen as 
> often as before), which I've added to:
> 
> http://www.komputilo.org/~joostje/linux/swsuspend/

There sometimes is not enough memory to suspend on your box, and
the BUG() triggers because nr_copy_pages_check is initialized too late.
The following patch should fix it.  Could you please test?

Greetings,
Rafael 


Index: linux-2.6.14-rc1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc1.orig/kernel/power/swsusp.c	2005-09-22 22:05:52.000000000 +0200
+++ linux-2.6.14-rc1/kernel/power/swsusp.c	2005-09-22 22:08:14.000000000 +0200
@@ -918,6 +918,7 @@
 
 	pagedir_nosave = NULL;
 	nr_copy_pages = calc_nr(nr_copy_pages);
+	nr_copy_pages_check = nr_copy_pages;
 
 	pr_debug("suspend: (pages needed: %d + %d free: %d)\n",
 		 nr_copy_pages, PAGES_FOR_IO, nr_free_pages());
@@ -940,7 +941,6 @@
 		return error;
 	}
 
-	nr_copy_pages_check = nr_copy_pages;
 	return 0;
 }
 

-- 
Rafael J. Wysocki, Ph.D.
Institute of Theoretical Physics
Faculty of Physics of Warsaw University
ul. Hoza 69, 00-681 Warsaw
[tel: +48 22 55 32 263]
[mob: +48 60 50 53 693]
----------------------------
One should not increase, beyond what is necessary,
the number of entities required to explain anything.
			-- William of Ockham
