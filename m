From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 25/57] docs: power: convert docs to ReST
Date: Tue, 16 Apr 2019 07:41:37 -0300
Message-ID: <20190416074137.53873332@coco.lan>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <cfab8842b681a84518b327980b08aee95d159605.1555382110.git.mchehab+samsung@kernel.org>
        <1616669.eeiCRjss8h@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1616669.eeiCRjss8h@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Em Tue, 16 Apr 2019 10:59:23 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> escreveu:

> On Tuesday, April 16, 2019 4:55:50 AM CEST Mauro Carvalho Chehab wrote:
> > Convert the PM documents to ReST, in order to allow them to
> > build with Sphinx.  
> 
> And what exactly is the motivation for doing that?

Providing a little of context, I tried to submit a patchset that would
just place existing documents on a sort of "staging" way, without
actually reformatting:

	https://lkml.org/lkml/2019/4/10/244

Jon had some concerns about such approach.

So, I split into one patch per subsystem. Then, I looked on each, and
opted to do the conversion, as, on several cases, the conversion
seemed to be easy enough.

My selfish motivation is that I was returning from vacations and wanted to
review some stuff at the Kernel docs, but, discovered that, despite we
started migrating the documentation on May, 2016, still the vast
majority of documents that weren't converted.

For me, the main motivation for the conversion are:

1) Documents will be grouped into books and chapters,
   with makes easier to study them;
2) The Sphinx javascript is very convenient for seeking a
   document and a keyword within the body of the document;
3) Using a browser to read documentation allows to better
   scale the document to the screen I'm using.

That's said, sometimes I just prefer to convert the document
to a PDF and read it on my tablet. PDF tools also provide 
similar features.

In other words, for my own consumption, I prefer reading 
documents using document tools, instead of reading in plain
text.

> There are plans for some of these files to be converted already, some of them need to be merged or split and it just is not worth it to convert some others.

Feel free to use this patch as an starting point. If you prefer,
I can split into smaller sets, but my main goal here is just
to help to speedup the conversion.

Thanks,
Mauro
