From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] block: always requeue !fs requests at the front
Date: Fri, 15 Jun 2007 14:58:56 +0100
Message-ID: <46729B20.309@dgreaves.com>
References: <200706020122.49989.rjw@sisk.pl> <46706968.7000703@dgreaves.com> <alpine.LFD.0.98.0706131507360.14121@woody.linux-foundation.org> <200706140115.58733.rjw@sisk.pl> <46714ECF.8080203@gmail.com> <46715A66.8030806@suse.de> <20070615094246.GN29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754758AbXFON71@vger.kernel.org>
In-Reply-To: <20070615094246.GN29122@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>, Jeff Garzik <jgarzik@pobox.com>, jens.axboe@oracle.com
List-Id: linux-pm@vger.kernel.org

> David, please test this.  Jens, does it look okay?

Phew!

Works for me.

I applied it to 2.6.22-rc4 (along with 
sata_promise_use_TF_interface_for_polling_NODATA_commands.patch) hibernate and 
resume worked.

Thanks for digging it out Tejun (and everyone else!) :)

David
